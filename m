From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:37:22 +0200
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <785558d1-519d-78c1-0a1b-7517f771c1e2@grimberg.me>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>
 <785558d1-519d-78c1-0a1b-7517f771c1e2@grimberg.me>
Message-ID: <b4f9b6e4-f0b4-312f-1eeb-4c292a8f9af1@suse.de>

On 4/30/19 7:54 AM, Sagi Grimberg wrote:
> 
>> I do like the idea, but not necessarily the naming.
>> Can't we just call it 'default.conf' ?
> 
> It's not as self-explanatory, but I'm fine with default.conf...
> 
>> What about precedence?
>> I would have expected that we should have
>>
>> defargs.conf
>> discovery.conf
>> <cmdline>
>>
>> Is that the case?
> 
> Effectively yes, but defargs does not allow transport,traddr,trsvcid,nqn
> parameters (which don't make sense), and discovery.conf is designed to
> hold exactly those. So in practice they should not overlap.
> 
Uh-oh. I _do_ know of cases where discovery.conf is used for precisely 
this purpose, ie holding _all_ arguments.
And in the absense of any other way existing implementations will be 
using a very similar thing.

> Also, we only go to discovery.conf if we did not get a transport+traddr
> (which are mandatory). So its not exactly the order you mentioned, more
> like:
> 
> defargs.conf
> <cmdline>
> if transport+traddr not given
> discovery.conf
> 
How very curious ...
I would have expected that any command-line args would overwrite any 
arguments given in the configuration files.
But given that discovery.conf can contain several lines I can see the 
problem.

However, to clean things up we should be updating the parser to ignore 
or even call an error if we find a line in discovery.conf which does not 
specify transport+traddr.
Just to avoid confusion.

>> And shouldn't we document that somewhere?
> Where would be the place to update this?
manpage?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
