From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 7 Jun 2018 12:00:35 +0200
Subject: [PATCH nvmetcli] ANA configuration support
In-Reply-To: <20180607095709.26738-1-hare@suse.de>
References: <20180607095709.26738-1-hare@suse.de>
Message-ID: <20180607100035.cbtwtvttsen2wwm3@linux-x5ow.site>

On Thu, Jun 07, 2018@11:57:09AM +0200, Hannes Reinecke wrote:
> +class ANA_Group(CFSNode):

Please use ANAGroup to be consistent with the rest and Python's PEP8
guidelines.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
