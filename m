From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 17 Feb 2017 09:58:27 +0100
Subject: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
In-Reply-To: <20170216201053.1190-2-hch@lst.de>
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
Message-ID: <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>

On 02/16/2017 09:10 PM, Christoph Hellwig wrote:
> -enum opal_response_token {
> -	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> -	OPAL_DTA_TOKENID_SINT = 0xe1,
> -	OPAL_DTA_TOKENID_UINT = 0xe2,
> -	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> -	OPAL_DTA_TOKENID_INVALID = 0X0

Nit, here's a capital 'X' that slipped in


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
