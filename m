From: james.smart@broadcom.com (James Smart)
Date: Mon, 15 Jul 2019 16:34:58 -0700
Subject: [PATCH rfc v2 09/10] nvme-cli: add --quiet option
In-Reply-To: <898fcfa4-e70f-fd0d-0905-cc4af74d4cda@broadcom.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-10-jsmart2021@gmail.com>
 <46dcab64-c4f9-74dc-b75c-4f4b8926051d@grimberg.me>
 <898fcfa4-e70f-fd0d-0905-cc4af74d4cda@broadcom.com>
Message-ID: <36f155f5-a661-1b5b-4596-55b7333abca0@broadcom.com>


On 7/14/2019 7:49 AM, James Smart wrote:
>
> On 7/12/2019 10:35 AM, Sagi Grimberg wrote:
>> When I pass it manually it works, but not from udev... Not sure what
>> is going on...
>
> ?? I'll check it on my side
>

yeah - the --quiet option wasn't passed right. It became part of the 
service name, not in the command invoked.

fixing it

-- james
