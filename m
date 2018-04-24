From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:41:02 +0200
Subject: [PATCH 08/20] nvmet: configure file backed ns for sync IO
In-Reply-To: <20180418190011.3973-9-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-9-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424174102.GA30909@lst.de>

On Wed, Apr 18, 2018@02:59:59PM -0400, Chaitanya Kulkarni wrote:
> This patch allows file backed namespaces to use newly
> introduced configfs attribute sync, when sync is set
> we open the file with O_SYNC and use the work queue
> to execute the NVMe read/write commands.

So this adds support for buffered I/O.  But why do you force
O_SYNC on everyone who uses buffered I/O?
