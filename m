From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 2 Aug 2015 09:57:53 +0200
Subject: [PATCH v6 5/5] nvme: LightNVM support
In-Reply-To: <1438082268-13496-6-git-send-email-mb@lightnvm.io>
References: <1438082268-13496-1-git-send-email-mb@lightnvm.io>
 <1438082268-13496-6-git-send-email-mb@lightnvm.io>
Message-ID: <20150802075753.GH3720@amd>

Hi!

> +struct nvme_nvm_hb_rw {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd2;
> +	__le64			metadata;
> +	__le64			prp1;
> +	__le64			prp2;
> +	__le64			slba;
> +	__le16			length;
> +	__le16			control;
> +	__le32			dsmgmt;
> +	__le64			phys_addr;
> +};

You are not exporting this to userland, so you can get rid of "__"s.

    	    	      	      		       	       	      Pavel
							      
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
