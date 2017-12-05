From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 5 Dec 2017 09:28:53 +0200
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning
 event
In-Reply-To: <20171204200721.GB17023@lst.de>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-2-sagi@grimberg.me> <20171204200721.GB17023@lst.de>
Message-ID: <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me>


>> In case a controller sent us a critical warning AER,
>> we should query the smart information and in case the
>> media was placed in read only mode, we need to set
>> all the controller namespaces (and the namespaces heads)
>> in read-only (or set to rw in case its not set).
>>
>> Given that in fabrics we may also connect to a read-only
>> subsystem, we add the disk as read-only to start with.
>> Once the subsystem will be in rw mode, we restore
>> the disk rw permissions.
> 
> We are sending the smart log notification on to userspace, so with this
> we now have two parties that are trying to clear the log page..

Not at the moment, but soon we will send smart logs to userspace, yes.

I guess we have two choices for this:

1. let userspace handle it and expose a knob to modify all controller
namespaces to r/o.

2. handle the event in the kernel, issue the log page with retain bit on
and only then notify userspace.

I personally prefer (2), what do others think?
