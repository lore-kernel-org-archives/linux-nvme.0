From: mb@lightnvm.io (Matias)
Date: Tue, 04 Aug 2015 14:00:09 +0200
Subject: [PATCH v6 5/5] nvme: LightNVM support
In-Reply-To: <20150802075753.GH3720@amd>
References: <1438082268-13496-1-git-send-email-mb@lightnvm.io>
 <1438082268-13496-6-git-send-email-mb@lightnvm.io>
 <20150802075753.GH3720@amd>
Message-ID: <55C0A949.1040406@lightnvm.io>

On 08/02/2015 09:57 AM, Pavel Machek wrote:
> Hi!
>
>> +struct nvme_nvm_hb_rw {
>> +	__u8			opcode;
>> +	__u8			flags;
>> +	__u16			command_id;
>> +	__le32			nsid;
>> +	__u64			rsvd2;
>> +	__le64			metadata;
>> +	__le64			prp1;
>> +	__le64			prp2;
>> +	__le64			slba;
>> +	__le16			length;
>> +	__le16			control;
>> +	__le32			dsmgmt;
>> +	__le64			phys_addr;
>> +};
>
> You are not exporting this to userland, so you can get rid of "__"s.
>
>      	    	      	      		       	       	      Pavel
> 							
>

Thanks. I will get them removed. It was a leftover for when it was in 
the nvme uapi header.
