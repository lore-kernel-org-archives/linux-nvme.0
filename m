From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 14 Apr 2016 08:23:26 -0700
Subject: I/O 0 QID 0 timeout, disable controller - kernel 4.4 / 4.5 NVMe
 controller dropouts
In-Reply-To: <570FA450.7080105@fb.com>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
 <20160414132113.GA21794@localhost.localdomain>
 <570FA450.7080105@fb.com>
Message-ID: <20160414152326.GA12458@infradead.org>

The code in the 4.7 tree still falls back to legacy irqs, it just tries
MSI-X first, then MSI, then legacy.  Which seems a common patters in
MSI-X using drivers, as I've just started a tree wide audit for the
usage of the MSI/MSI-X APIs.
