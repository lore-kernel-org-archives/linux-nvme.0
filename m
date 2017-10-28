From: james.smart@broadcom.com (James Smart)
Date: Sat, 28 Oct 2017 09:08:50 -0700
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <f0300e47-e219-19f9-1495-a662f9062b4d@suse.de>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
 <e542bb4d-946f-a080-5701-f8019fdbc752@suse.de>
 <352f980c-2422-f917-a551-99bedf27e0ab@broadcom.com>
 <f0300e47-e219-19f9-1495-a662f9062b4d@suse.de>
Message-ID: <159cfcc6-40e8-9062-7341-9a3de5f177af@broadcom.com>

On 10/28/2017 6:34 AM, Hannes Reinecke wrote:
>
> Oh, I know that.
> What I would prefer is to have a single udev rule per nvme connection,
> containing both lport and rport information.
> That would relieve us of having additional configuration, and we can
> enable/disable connection by just having that udev rule.
> This works pretty well; we're doing it exactly the same way on S/390 for
> the network and zfcp connections.
> So if we have that then we only need to know when the lport/rport
> combination is ready; once that is done we can call the udev rule.
> Ideally we'll be getting an event containing both of these informations,
> then udev will be selecting the correct rule automatically.
>
> Cheers,
>
> Hannes

The main reason for the systemd use was the potential duration of the 
resulting nvme connect-all. The scripts are simple if udev makes the 
nvme cli call and don't require anything other than a single generic 
rule. But given its potential stalls, very bad.

If I understand you correctly, what you describe requires apriori 
knowledge of the connections in order to add the udevs rule. This is a 
step backward from current FC behavior and what users are used to.

-- james
