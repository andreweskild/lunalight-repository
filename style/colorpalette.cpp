#include "colorpalette.h"

static ColorPalette *s_instance = nullptr;

ColorPalette::ColorPalette(QObject *parent) : QObject(parent),
    m_lightness(ColorPalette::Dark)
{
    updateLightness();
}

void ColorPalette::registerSingleton(QQmlEngine *p_qmlEngine) {
    if (s_instance == nullptr) {
        s_instance = new ColorPalette(p_qmlEngine);
    }

    QQmlContext *rootContext = p_qmlEngine->rootContext();
    rootContext->setContextProperty("ColorPalette", s_instance);
}

void ColorPalette::updateLightness()
{
    switch(m_lightness)
    {
        case ColorPalette::Light:
        {
            changeToLightColorPalette();
            break;
        }
        case ColorPalette::Dark:
        {
            changeToDarkColorPalette();
            break;
        }
    }
}

void ColorPalette::changeToLightColorPalette()
{
    m_accent = QColor::fromRgb(255, 207, 35);
    m_accentLight = QColor::fromRgb(255, 238, 153);
    m_accentDark = QColor::fromRgb(245, 186, 23);
    m_accentHighlight = QColor::fromRgb(255, 227, 121);
    m_accentBorder = QColor::fromRgb(232, 170, 25);

    m_content = QColor::fromRgb(101, 93, 109);
    m_contentSecondary = QColor::fromRgb(255, 255, 255);
    m_contentAccented = QColor::fromRgb(147, 84, 22);

    m_window = QColor::fromRgb(230, 227, 232);
    m_windowHighlight = QColor::fromRgb(242, 241, 243);

    m_sunken = QColor::fromRgb(217, 214, 220);
    m_sunkenBorder = QColor::fromRgb(204, 200, 208);

    m_sunkenDark = QColor::fromRgb(152, 144, 160);
    m_sunkenDarkBorder = QColor::fromRgb(103, 95, 110);

    m_raised = QColor::fromRgb(244, 243, 244);
    m_raisedHighlight = QColor::fromRgb(254, 254, 255);
    m_raisedBorder = QColor::fromRgb(204, 200, 208);

    m_shadow = QColor(0, 0, 0, 30);
}

void ColorPalette::changeToDarkColorPalette() {
    m_background = QColor("#404040");

    m_textPrimary = QColor("#FFFFFF");
    m_textSecondary = QColor("#C5C5C5");


    m_buttonDefault = QColor("#8B8B8B");
    m_buttonFocused = QColor("#D85068");
}


ColorPalette::Lightness ColorPalette::lightness() const
{
    return m_lightness;
}

void ColorPalette::setLightness(const ColorPalette::Lightness &p_lightness)
{
    if (m_lightness != p_lightness)
    {
        m_lightness = p_lightness;
        emit lightnessChanged();
        updateLightness();
    }
}
