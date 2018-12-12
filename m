From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 00:38:27 +0000
Subject: [PATCH 10/12] nvmet: add error log support for admin-cmd
In-Reply-To: <3501d39f-76db-0f10-8ca6-0d397c53f273@grimberg.me>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB4502206C5362955EF2F2014686A50@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20181211141547.GA8591@lst.de>,
 <3501d39f-76db-0f10-8ca6-0d397c53f273@grimberg.me>
Message-ID: <BYAPR04MB4502EC5E5E9EAC45C1F831D986A70@BYAPR04MB4502.namprd04.prod.outlook.com>







From: Sagi Grimberg <sagi@grimberg.me>
Sent: Tuesday, December 11, 2018 3:59 PM
To: hch at lst.de; Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; keith.busch at intel.com
Subject: Re: [PATCH 10/12] nvmet: add error log support for admin-cmd
? 
 

>> I'm wandering how we can guarantee that we don't forget to set
>> req->error_loc for all future errors...
>>
>> Anyways..
>>
>> [CK] One way to do that is to have a default centralized mapping from the error codes,
>> not sure if that is worth an effort though, will skip this for now.
> 
> Well, the M bit and the error log page are optional features.
> Maybe we should only set the M bit and generate a log page if error_loc
> is set?? Although for that we'd need to initialize it to -1 as 0
> is a valid error location.
> 
> We could then also add a debug option to print a warning for errors
> without error_loc if we care enough.

Sounds good to me...



[CK] Okay, will send a new series with Christoph's suggestion.    
