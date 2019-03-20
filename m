From: fam@euphon.net (Fam Zheng)
Date: Wed, 20 Mar 2019 10:54:15 +0800
Subject: [PATCH 4/9] nvme/pci: use the NVME_CTRL_SUSPENDED state
In-Reply-To: <20190319144116.400-5-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319144116.400-5-mlevitsk@redhat.com>
Message-ID: <20190320025415.bli42qmifuu5gxdm@deb>

On Tue, 03/19 16:41, Maxim Levitsky wrote:
> When enteriing low power state, the nvme

Typo: "entering".

> driver will now inform the core with the NVME_CTRL_SUSPENDED state
> which will allow mdev driver to act on this information

[snip]

Fam
