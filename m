From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Aug 2016 14:24:14 +0300
Subject: two small nvmf fixes for 4.8
In-Reply-To: <1471544196-30525-1-git-send-email-hch@lst.de>
References: <1471544196-30525-1-git-send-email-hch@lst.de>
Message-ID: <bcb7bf6e-24bc-61e8-009a-b8a2c1fff552@grimberg.me>


> One is a potential use after free that will actually be easy to trigger
> with the new default hostnqn support in nvme-cli, and the other fixes
> up the dependencies in the Kconfig file so that we don't always drag in
> the traditional NVMe PCIe driver.

Queued to nvmf-4.8-rc, thanks Christoph...
