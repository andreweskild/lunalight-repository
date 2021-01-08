/*
 * This file is part of Tulip.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "colorpalette.h"
#include "style.h"
#include <QFontDatabase>

static QObject *colorProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new ColorPalette();
}


//void TulipStylePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
//{
//   // Q_ASSERT(QLatin1String(uri) == QLatin1String("Tulip.Style"));

//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Bold.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-BoldItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-ExtraLight.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-ExtraLightItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Italic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Light.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-LightItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Medium.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-MediumItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Regular.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-SemiBold.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-SemiBoldItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Text.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-TextItalic.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-Thin.ttf");
//    QFontDatabase::addApplicationFont(":/fonts/IBMPlexSans-ThinItalic.ttf");
//    // For system icons
//    engine->addImageProvider(QLatin1String("tulipicontheme"), new IconThemeImageProvider());
//}

void StylePlugin::registerTypes(const char *uri)
{
    qmlRegisterSingletonType<ColorPalette>(uri, 1, 0, "ColorPalette", colorProvider);
}
