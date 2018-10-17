From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Oct 2018 17:38:04 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
 <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>
 <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
 <3e7e99bc-deff-795f-0f0b-de3f50c3a50a@grimberg.me>
 <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
Message-ID: <f59d1bbf-eead-6818-5994-d0271132a3a2@grimberg.me>


>> Hannes,
>>
>> Do you agree that it would suffice? Or, Do you think we should take
>> a different approach?
>>
>> Would like to get some feedback from others given that this is not
>> a trivial decision about which way we go here..
> 
> Actually, I have looked at the original solution from James Smart for 
> FC-NVMe autoconnect.
> 
> Essentially he starts a system service from a udev rule, which in itself 
> is triggered by the event.
> With that we're out of the udev program timeout (as systemd services can 
> run for arbitrarily long) _and_ we also have resolved the problem of a 
> uevent storm, as systemd will manage that for us.

That's a good idea!

> The only problem here is that we need to pass arguments to the systemd 
> service, but if we can use the standard udev trick of placing the 
> arguments into the program environment and having the program looking 
> for that we should be able to solve that, too.
> 
> Would you be okay with this approach?

I'm fine with this approach. There are enough ways to
pass in args to systemd:

Something like:

SUBSYSTEM=="nvme", ACTION=="change", \
    RUN+=systemctl start nvmf-disc-change@" 
--device=nvme$env{NVME_INSTANCE} --transport=$env{NVME_TRTYPE} 
--traddr=$env{NVME_TRADDR} --trsvcid=$env{NVME_TRSVCID}".service

And nvmf-disc-change at .service is:
--
[Unit]
Description=NVMe automatic discovery upon discovery log change updates

[Service]
Environment="CONNECTALL_ARGS=%I"
ExecStart=nvme connect-all $CONNECTALL_ARGS
--

We could also add EnvironmentFile for additional parameters
(nr_io_queues, etc...)

Thoughts?
