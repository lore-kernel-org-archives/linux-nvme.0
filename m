From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Aug 2017 07:36:29 -0700
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
In-Reply-To: <1503922057-1141-1-git-send-email-omri@excelero.com>
References: <1503922057-1141-1-git-send-email-omri@excelero.com>
Message-ID: <20170828143629.GA24146@infradead.org>

On Mon, Aug 28, 2017@03:07:37PM +0300, Omri Mann wrote:
> Add host_id feature to NVMeoF targets. This will be required in order to
> support reservations.

For Fabrics the host id is set in the connect command and Set Features
must return an error (see section 5.21.1.19.2 in NVMe 1.3).  But the
Get Features is still useful.
