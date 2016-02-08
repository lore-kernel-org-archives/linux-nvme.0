From: hch@lst.de (Christoph Hellwig)
Date: Mon,  8 Feb 2016 19:09:47 +0100
Subject: nvme: return the whole CQE through the request passthrough interface
Message-ID: <1454954988-32306-1-git-send-email-hch@lst.de>

See http://www.infradead.org/rpr.html

For NVMe over Fabrics we need the whole completion queue available
through the request interface in some cases, and Matias mentioned could
use this for LighNVM as well.

The attached patch uses req->special to allow passing a whole CQE around
that the low level driver can fill out.
