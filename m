From: hch@lst.de (Christoph Hellwig)
Date: Fri, 3 May 2019 14:18:38 +0200
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <20190502114801.23116-1-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
Message-ID: <20190503121838.GA21041@lst.de>

I simply don't get the point of this series.

MDEV is an interface for exposing parts of a device to a userspace
program / VM.  But that this series appears to do is to expose a
purely software defined nvme controller to userspace.  Which in
principle is a good idea, but we have a much better framework for that,
which is called vhost.
