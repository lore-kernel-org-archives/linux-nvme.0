From: kwan.huen@samsung.com (kwan.huen@samsung.com)
Date: Thu, 10 Aug 2017 19:54:09 -0700
Subject: [PATCH] nvme-cli: add support for directive command
References: <CGME20170811025053epcas2p1ec98081d04a0488a2c08836c909f368c@epcas2p1.samsung.com>
Message-ID: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>

Directive is a feature introduced in NVMe v1.3 that allows host
and NVM subsystem or controller information exchange, namely data
lifetime hint for example. Information is transmitted using
the Directive Send and Directive Receive commands.

This patch set allows control of the directive resources of a
directive-enabled nvme device.
