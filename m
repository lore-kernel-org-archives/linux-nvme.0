From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 26 Apr 2017 23:40:41 -0700
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
 <20170424145842.GA32128@infradead.org>
 <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>
Message-ID: <20170427064041.GB28074@infradead.org>

On Tue, Apr 25, 2017@09:20:00AM +0800, Guan Junxiong wrote:
> Hi ,Christoph:
>    What's the benefits of this feature? If we execute the following cmd
> 10 times, it will generate 10 character and at least 20 block devices.

The number of block devices will depend on the number of namespaces
configured, but yes, this is expected.  The NVMe architecture allows
for multiple connections from a given host to a subsystem.
