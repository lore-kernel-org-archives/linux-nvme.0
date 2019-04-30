From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Apr 2019 00:34:50 -0700
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <b4f9b6e4-f0b4-312f-1eeb-4c292a8f9af1@suse.de>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>
 <785558d1-519d-78c1-0a1b-7517f771c1e2@grimberg.me>
 <b4f9b6e4-f0b4-312f-1eeb-4c292a8f9af1@suse.de>
Message-ID: <e060385b-7695-d5b1-d4ca-2357e016219d@grimberg.me>


>> Effectively yes, but defargs does not allow transport,traddr,trsvcid,nqn
>> parameters (which don't make sense), and discovery.conf is designed to
>> hold exactly those. So in practice they should not overlap.
>>
> Uh-oh. I _do_ know of cases where discovery.conf is used for precisely 
> this purpose, ie holding _all_ arguments.

That's fine.. it was never designed for this purpose though...

> And in the absense of any other way existing implementations will be 
> using a very similar thing.

Again, this would work.

>> Also, we only go to discovery.conf if we did not get a transport+traddr
>> (which are mandatory). So its not exactly the order you mentioned, more
>> like:
>>
>> defargs.conf
>> <cmdline>
>> if transport+traddr not given
>> discovery.conf
>>
> How very curious ...
> I would have expected that any command-line args would overwrite any 
> arguments given in the configuration files.
> But given that discovery.conf can contain several lines I can see the 
> problem.

Exactly. discovery.conf was simply added such that you can run nvme
connect-all without explicitly passing parameters so you can build
auto-connect scripts on top of.

> However, to clean things up we should be updating the parser to ignore 
> or even call an error if we find a line in discovery.conf which does not 
> specify transport+traddr.
> Just to avoid confusion.

It will fail, the command will fail for lacking a mandatory parameter.

>>> And shouldn't we document that somewhere?
>> Where would be the place to update this?
> manpage?

Well discovery.conf is quite a generic name...
also don't you think a full blown man page is an overkill?

both files have some documentation in them, we could enhance those
a bit...
