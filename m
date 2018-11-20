From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:27:31 +0100
Subject: tweak multipath kconfig and options
Message-ID: <20181120162734.2013-1-hch@lst.de>

Based on all the flames lately I think we need to make the
Kconfig description of CONFIG_NVME_MULTIPATH a little more clear,
and also warn people if they use unsupported and dangerous setups.
