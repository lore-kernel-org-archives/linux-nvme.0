From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:59:36 -0800
Subject: [PATCH 10/12] nvmet: add error log support for admin-cmd
In-Reply-To: <20181211141547.GA8591@lst.de>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB4502206C5362955EF2F2014686A50@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20181211141547.GA8591@lst.de>
Message-ID: <3501d39f-76db-0f10-8ca6-0d397c53f273@grimberg.me>


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
> is set?  Although for that we'd need to initialize it to -1 as 0
> is a valid error location.
> 
> We could then also add a debug option to print a warning for errors
> without error_loc if we care enough.

Sounds good to me...
