From: james.smart@broadcom.com (James Smart)
Date: Mon, 26 Sep 2016 07:55:58 -0700
Subject: [PATCH 3/3] nvme-fabrics: Move controller id to opts struct
In-Reply-To: <20160926144227.GA9792@infradead.org>
References: <57e9321a.e6Pgooc71MbSI4hg%james.smart@broadcom.com>
 <20160926144227.GA9792@infradead.org>
Message-ID: <f3b57b6f-245c-536e-3517-a3a995d5e721@broadcom.com>

Hmm.  How does one connect to a static vs dynamic controller then ?   
Today, we would only connect to a dynamic as the fabrics code hardcodes 
the value to 0xFFFF.    For static controllers, the first connect needs 
to be to 0xFFFE, and subsequent reconnects can be to the exact 
controller id number returned earlier.

As such, I don't understand your comment. At a minimum, we need to allow 
0xFFFE and 0xFFFF.

True - our target subsystem is only dynamic, but I would assume our host 
infrastructure does either.

-- james



On 9/26/2016 7:42 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2016@07:35:06AM -0700, James Smart wrote:
>> The FC transport needs the controller ID for transport connect which occur
>> prior to the fabric connect command.  Currently, it's hardcoded in the
>> fabrics code for the fabric connect cmd formatting routine.
>>
>> Reworked to have controller id set in the opts structure. Adds support
>> for controller id to be specified as an option.
> Having the controller ID as the option really doesn't make sense, we'll
> take what the target side gives us during the admin connect.
>
