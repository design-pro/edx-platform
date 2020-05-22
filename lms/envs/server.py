from .devstack import *  # pylint: disable=wildcard-import, unused-wildcard-import

WEBPACK_CONFIG_PATH = 'webpack.prod.config.js'
REQUIRE_DEBUG = DEBUG
DEBUG = False
DEFAULT_TEMPLATE_ENGINE['OPTIONS']['debug'] = False
