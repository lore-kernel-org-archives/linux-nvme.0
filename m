From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Sep 2017 15:55:28 +0200
Subject: nvme host memory buffer fixes and updates
Message-ID: <20170906135532.21358-1-hch@lst.de>

Hi all,

this series fixes a few bugs in the HMB code, and adds support
for two trivial new tunables exposed by some devices.
