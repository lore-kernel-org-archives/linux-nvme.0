From: John.Meneghini@netapp.com (Meneghini, John)
Date: Fri, 4 May 2018 17:03:54 +0000
Subject: [PATCH 2/5] nvme: Add ANA base definitions
In-Reply-To: <20180504161736.GQ5938@localhost.localdomain>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-3-hare@suse.de>
 <20180504161736.GQ5938@localhost.localdomain>
Message-ID: <FED93B0B-94E0-41B2-A790-60C665287037@netapp.com>

Agreed: 

95:92 - ANAGRPID
103:96 - Reserved

Note that this was changed at the last minute.  There are some older drafts of the NVM_TP_4004 out there.  You want to be sure to use the ratified version from:

http://nvmexpress.org/resources/specifications/

NVM Express 1.3 Ratified TPs

/John

?On 5/4/18, 12:16 PM, "Keith Busch" <keith.busch@linux.intel.com> wrote:

    On Fri, May 04, 2018@01:28:42PM +0200, Hannes Reinecke wrote:
    > @@ -312,7 +317,8 @@ struct nvme_id_ns {
    >  	__le16			nabspf;
    >  	__le16			noiob;
    >  	__u8			nvmcap[16];
    > -	__u8			rsvd64[40];
    > +	__u8			rsvd64[36];
    > +	__le32			anagrpid;
    >  	__u8			nguid[16];
    >  	__u8			eui64[8];
    >  	struct nvme_lbaf	lbaf[16];
    
    Is this the right place for the new field? Your patch has the group ID
    at byte 100. TP4004 has the ANA Group Identifier starting at byte 92,
    followed by 8 reserved bytes, then the NGUID.
    
