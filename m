From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 13:11:49 +0200
Subject: [PATCH 0/2] nvme_fc: add uevent to allow dynamic connects
In-Reply-To: <20170505231335.31726-1-jsmart2021@gmail.com>
References: <20170505231335.31726-1-jsmart2021@gmail.com>
Message-ID: <2340db12-7f96-1d05-de6a-f36ddb913e4f@suse.de>

On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> These patches add support for generating a uevent which can be
> caugth and converted to a nvme-cli connect-all request for the
> FC initiator and target ports.

IMHO this should be a bit more generic. We do have two fabrics, FC and
RDMA (we can leave out PCIe here I think). *Iff* we want to do this we
at least need to do this for FC _and_ RDMA.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
