From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 09:12:19 -0700
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between
 same port pairs
In-Reply-To: <20170914173843.3195-4-jsmart2021@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-4-jsmart2021@gmail.com>
Message-ID: <20170918161219.GB310@infradead.org>

On Thu, Sep 14, 2017@10:38:43AM -0700, James Smart wrote:
> Rescans can occur due to subsystem list changes on an FC remoteport.
> Rescans may attempt to reconnect to subsystems where there is already
> an association in place. There should only be 1 association in place
> at a time for the following tuple:
>   <hostnqn, hostid, host FC port, target FC port, subnqn>

There is absolutely no requirement for this limitation in the NVMe
spec.
