From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 10:11:39 +0100
Subject: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
In-Reply-To: <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
 <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
Message-ID: <20170217091139.GA19393@lst.de>

On Fri, Feb 17, 2017@09:58:27AM +0100, Johannes Thumshirn wrote:
> On 02/16/2017 09:10 PM, Christoph Hellwig wrote:
> > -enum opal_response_token {
> > -	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> > -	OPAL_DTA_TOKENID_SINT = 0xe1,
> > -	OPAL_DTA_TOKENID_UINT = 0xe2,
> > -	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> > -	OPAL_DTA_TOKENID_INVALID = 0X0
> 
> Nit, here's a capital 'X' that slipped in

I just moved the existing definition around 1:1.
