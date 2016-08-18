From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Aug 2016 11:16:34 -0700
Subject: two small nvmf fixes for 4.8
Message-ID: <1471544196-30525-1-git-send-email-hch@lst.de>

One is a potential use after free that will actually be easy to trigger
with the new default hostnqn support in nvme-cli, and the other fixes
up the dependencies in the Kconfig file so that we don't always drag in
the traditional NVMe PCIe driver.
