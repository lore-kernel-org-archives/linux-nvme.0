From: jsmart2021@gmail.com (James Smart)
Date: Mon, 18 Sep 2017 17:07:44 -0700
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between same
 port pairs
In-Reply-To: <20170918231715.GB12410@infradead.org>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-4-jsmart2021@gmail.com>
 <20170918161219.GB310@infradead.org>
 <7f610102-562c-18e0-659a-ff06b0186ac2@broadcom.com>
 <20170918231715.GB12410@infradead.org>
Message-ID: <0fc47d1d-88d3-c598-1ff2-24488c6b0789@gmail.com>

On 9/18/2017 4:17 PM, Christoph Hellwig wrote:
> On Mon, Sep 18, 2017@09:28:35AM -0700, James Smart wrote:
>> The desire for FC is to have the same dynamic discovery that it has for
>> SCSI. Thus the udev events that kick off scanning. The events are posted
>> when connectivity is first detected as well as conditions where the
>> discovery server content may have changed (new subsystems added for
>> example).? Since those events are ignorant of what's already connected, it
>> make no sense to create additional controllers/devices if there's already a
>> controller connected.
>>
>> The alternative is to drive all connections manually which makes a very
>> difficult to manage system for an administrator, especially on "cable-pull"
>> scenarios. There is no need for this with FC.
> 
> The add a connect options that checks for duplicates instead of making
> it the only options.  And please make it a global check for all
> fabrics transports.
> 

So we're on the same page - I'll add the option for "check for 
duplicates" to the cli, which will pass it on to the kernel, but the 
implementation of the check will be in the kernel in each transport.

By keeping the check in the kernel it will:
- avoid race conditions of what the "active controller" list is between 
user and kernel space
- keep transport-port specific knowledge of what connect fields are 
meaningful in the transport,
- avoids adding any infrastructure to get the connect fields into user 
space if the cli were to do the checking.

-- james
