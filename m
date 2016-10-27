From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Oct 2016 08:41:15 +0200
Subject: A question regarding "multiple SGL"
In-Reply-To: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
References: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
Message-ID: <20161027064115.GA5864@lst.de>

Hi Robert,

There is no feature called "Multiple SGL in one NVMe capsule".  The
NVMe over Fabrics specification allows a controller to advertise how
many SGL descriptors it supports using the MSDBD Identify field:

"Maximum SGL Data Block Descriptors (MSDBD): This field indicates the
maximum number of (Keyed) SGL Data Block descriptors that a host is allowed to
place in a capsule. A value of 0h indicates no limit."

Setting this value to 1 is perfectly valid.  Similarly a host is free
to chose any number of SGL descriptors between 0 (only for command that
don't transfer data) to the limit imposed by the controller using the
MSDBD field.

There are no plans to support a MSDBD value larger than 1 in the Linux
NVMe target, and there are no plans to ever submit commands with multiple
SGLs from the host driver either.

Cheers,
	Christoph
