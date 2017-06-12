From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 12 Jun 2017 12:04:18 +0200
Subject: [PATCH v2] nvme: use uuid_t in nvme_ns
In-Reply-To: <CAHp75Ve+-+s3Fx4MnjXoXf3tjh_PkdnEKAKrXnmFWA_38_abnw@mail.gmail.com>
References: <20170612091240.18343-1-jthumshirn@suse.de>
 <CAHp75Ve+-+s3Fx4MnjXoXf3tjh_PkdnEKAKrXnmFWA_38_abnw@mail.gmail.com>
Message-ID: <52228639-aedd-fdb9-0f02-448f8982758a@suse.de>

On 06/12/2017 11:50 AM, Andy Shevchenko wrote:
>>                         len = NVME_NIDT_UUID_LEN;
>> -                       memcpy(ns->uuid, data + pos + sizeof(*cur), len);
>> +                       uuid_copy(&ns->uuid, data + pos + sizeof(*cur));
> 
> So, this reveals two thins:
> 1) shall we define NVME_NIDT_UUID_LEN to be UUID_LEN or substitute it
> completely with the latter?

No, we have NVME_NIDT_UUID_LEN but also NVME_NIDT_NGUID_LEN and
NVME_NIDT_EUI64_LEN.

> 2) Is the len variable used later in the function?

Yes, we have to iterate the buffer by len, which can (currently) be
either 8 or 16 bytes. New types which may emerge someday in the future
might have a different length.

> 
>> -               if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)) ||
>> +               if (uuid_is_null(&ns->uuid) ||
>>                     !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
> 
>>         u8 nguid[16];
>> -       u8 uuid[16];
>> +       uuid_t uuid;
> 
> Do you plan to switch nguid to be guid_t / uuid_t ?
> 

I'm not sure the NVMe NGUID is the same as a GUID (a.k.a little endian
UUID). Quoting from the spec:

"This field uses the EUI-64 based 16-byte designator format. Bytes
114:112 contain the 24-bit Organizationally Unique Identifier (OUI)
value assigned by the IEEE Registration Authority. Bytes 119:115 contain
an extension identifer assigned by the corresponding organization. Bytes
111:104 contain the vendor specific extension identifier assigned by the
corresponding organization. See the IEEE EUI-64 guidelines for more
information."

But maybe Christoph can clarify it.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
