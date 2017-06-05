From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:33:00 +0200
Subject: [PATCH v4 1/8] nvme: introduce NVMe Namespace Identification
 Descriptor structures
In-Reply-To: <fda3105a-706d-0b38-6ff8-8b69749d8374@grimberg.me>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-2-jthumshirn@suse.de>
 <fda3105a-706d-0b38-6ff8-8b69749d8374@grimberg.me>
Message-ID: <20170605053300.GC19480@lst.de>

On Sun, Jun 04, 2017@05:59:06PM +0300, Sagi Grimberg wrote:
>>   +struct nvme_ns_identifier_hdr {
>> +	__u8 nidt;
>> +	__u8 nidl;
>> +	__le16 reserved;
>> +};
>
> Nit: _hdr is usually associated with a message or alike.
>
> Maybe nvme_ns_id_desc is more consistent with the spec language.

The descriptor itself includes the actual value, that's why
I suggested adding the _hdr prefix.  But I'm fine going either way.
