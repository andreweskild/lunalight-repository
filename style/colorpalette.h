#ifndef COLORPALETTE_H
#define COLORPALETTE_H

#include <QObject>
#include <QColor>
#include <QQmlEngine>
#include <QtQml>


class ColorPalette : public QObject
{
    Q_OBJECT

    Q_PROPERTY(Lightness lightness READ lightness WRITE setLightness NOTIFY lightnessChanged)

    Q_PROPERTY(QColor background MEMBER m_background NOTIFY lightnessChanged)

    Q_PROPERTY(QColor buttonDefault MEMBER m_buttonDefault NOTIFY lightnessChanged)
    Q_PROPERTY(QColor buttonFocused MEMBER m_buttonFocused NOTIFY lightnessChanged)
    Q_PROPERTY(QColor textPrimary MEMBER m_textPrimary NOTIFY lightnessChanged)
    Q_PROPERTY(QColor textSecondary MEMBER m_textSecondary NOTIFY lightnessChanged)

    Q_PROPERTY(QColor accent MEMBER m_accent NOTIFY lightnessChanged)
    Q_PROPERTY(QColor accentLight MEMBER m_accentLight NOTIFY lightnessChanged)
    Q_PROPERTY(QColor accentDark MEMBER m_accentDark NOTIFY lightnessChanged)
    Q_PROPERTY(QColor accentHighlight MEMBER m_accentHighlight NOTIFY lightnessChanged)
    Q_PROPERTY(QColor accentBorder MEMBER m_accentBorder NOTIFY lightnessChanged)

    Q_PROPERTY(QColor content MEMBER m_content NOTIFY lightnessChanged)
    Q_PROPERTY(QColor contentSecondary MEMBER m_contentSecondary NOTIFY lightnessChanged)
    Q_PROPERTY(QColor contentAccented MEMBER m_contentAccented NOTIFY lightnessChanged)

    Q_PROPERTY(QColor window MEMBER m_window NOTIFY lightnessChanged)
    Q_PROPERTY(QColor windowHighlight MEMBER m_windowHighlight NOTIFY lightnessChanged)

    Q_PROPERTY(QColor sunken MEMBER m_sunken NOTIFY lightnessChanged)
    Q_PROPERTY(QColor sunkenBorder MEMBER m_sunkenBorder NOTIFY lightnessChanged)

    Q_PROPERTY(QColor sunkenDark MEMBER m_sunkenDark NOTIFY lightnessChanged)
    Q_PROPERTY(QColor sunkenDarkBorder MEMBER m_sunkenDarkBorder NOTIFY lightnessChanged)

    Q_PROPERTY(QColor raised MEMBER m_raised NOTIFY lightnessChanged)
    Q_PROPERTY(QColor raisedHighlight MEMBER m_raisedHighlight NOTIFY lightnessChanged)
    Q_PROPERTY(QColor raisedBorder MEMBER m_raisedBorder NOTIFY lightnessChanged)

    Q_PROPERTY(QColor shadow MEMBER m_shadow NOTIFY lightnessChanged)

public:
    enum Lightness {
        Light,
        Dark
    };
    Q_ENUM(Lightness)

    explicit ColorPalette(QObject *parent = nullptr);
    static void registerSingleton(QQmlEngine *p_qmlEngine);
    static QObject *singletonProvider(QQmlEngine *, QJSEngine *);

    Lightness lightness() const;

public slots:
    void setLightness(const Lightness &p_lightness);

signals:
    void lightnessChanged();

private:
    void updateLightness();
    void changeToDarkColorPalette();
    void changeToLightColorPalette();

    Lightness m_lightness;

    QColor m_background;

    QColor m_buttonDefault;
    QColor m_buttonFocused;

    QColor m_textPrimary;
    QColor m_textSecondary;

    QColor m_accent;
    QColor m_accentLight;
    QColor m_accentDark;
    QColor m_accentHighlight;
    QColor m_accentBorder;

    QColor m_content;
    QColor m_contentSecondary;
    QColor m_contentAccented;

    QColor m_window;
    QColor m_windowHighlight;

    QColor m_sunken;
    QColor m_sunkenBorder;

    QColor m_sunkenDark;
    QColor m_sunkenDarkBorder;

    QColor m_raised;
    QColor m_raisedHighlight;
    QColor m_raisedBorder;

    QColor m_shadow;
};

#endif // COLORPALETTE_H
