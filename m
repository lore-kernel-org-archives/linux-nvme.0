From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 16:51:08 +0200
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <e751810f-bb91-f764-dd51-ce2faaf209f0@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <e751810f-bb91-f764-dd51-ce2faaf209f0@huawei.com>
Message-ID: <20170829145108.GB32673@lst.de>

On Tue, Aug 29, 2017@06:22:50PM +0800, Guan Junxiong wrote:
> Does this introduce conflicts with current DM-Multipath used for NVMe/NVMeF
> when path IO error occurs?  Such IO will be retried not only on the nvme-mpath
> internal path, but also on the dm-mpath path.

It will not reach back to dm-multipath if we fail over here.
