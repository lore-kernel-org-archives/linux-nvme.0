From: hare@suse.de (Hannes Reinecke)
Date: Fri, 29 Mar 2019 11:23:18 +0100
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem cntlid
 enumeration
In-Reply-To: <20190329100244.GA28689@lst.de>
References: <20190329095754.109653-1-hare@suse.de>
 <20190329100244.GA28689@lst.de>
Message-ID: <edde200c-dc35-8e40-6406-ce72f8aafe17@suse.de>

On 3/29/19 11:02 AM, Christoph Hellwig wrote:
> On Fri, Mar 29, 2019@10:57:54AM +0100, Hannes Reinecke wrote:
>> The controller ID is supposed to be unique for each subsystem;
>> however, if it _isn't_ we will crash when calling device_add_disk()
>> for the namespaces.
>> While this surely is an error on the subsystem side we really shouldn't
>> crash. So simply use the 'instance' number when generating the disk
>> name to avoid this issue.
> 
> I agree that we should not crash in that, but I'd rather print an
> error message and reject using that controller with the duplicate
> controller id than hacking around the issue.
> 
As it so happens, I have a patch for that, too, but thought this one an 
easier solution :-)

Will be sending that patch, then.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
