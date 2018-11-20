From: hare@suse.de (Hannes Reinecke)
Date: Tue, 20 Nov 2018 17:05:44 +0100
Subject: [PATCH nvme-cli] nvme_fc auto-connect scripts
In-Reply-To: <df49114f-99e9-cca0-c99e-2df237c910c2@grimberg.me>
References: <20181116080024.12078-1-hare@suse.de>
 <df49114f-99e9-cca0-c99e-2df237c910c2@grimberg.me>
Message-ID: <e0ebf02b-faaa-799c-7374-daf183a7866b@suse.de>

On 11/19/18 11:53 PM, Sagi Grimberg wrote:
> 
>> From: James Smart <jsmart2021 at gmail.com>
>>
>> Sagi recently posted a "one-shot" call to nvme-connect via a systemd
>> script. FC has no problems operating with it assuming all the required
>> connect fields are present (host_traddr required).
> 
> 
> I think that this is a good approach. Can we add a preparatory patch
> that will allow nvme-cli to accept nil/none arguments? This way
> we can have the kernel shoot consistent udev events where parameters
> can stay don't-care and we can have the same rule...
> 
> If nvme-cli can accept a command in the form:
> nvme connect-all --traddr=<a> --host-traddr=<b> --trsvcid=none
> 
Good point, ans something which I had been thinking about, too.
But really it only makes sense if these scripts are supposed to work on 
different fabrics.

> I think we can consolidate a bit more (it will be a different device
> because for IP stuff the device will be the controller char device).
> 
> Perhaps we should change the name 70-nvmefc-autoconnect.rules to
> 70-nvmf-autoconnect.rules that will contain rules fc and IP in the
> same rule file...
> 
Of course we can make it more general.

It was just that buy-in from other subsystems into doing autoconnect was 
rather reluctant.

I'll be resending the patches.

Cheers,

Hannes
