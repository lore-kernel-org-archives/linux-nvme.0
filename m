From: daggs@gmx.com (daggs)
Date: Thu, 20 Apr 2017 19:44:16 +0200
Subject: question about spec hw reset
Message-ID: <trinity-e0cf29b4-06e9-4f13-aa54-8f1689d8ff58-1492710256428@3capp-mailcom-bs16>

Greetings,

I have a question about the hw reset flow. I'm maintaining a kernel driver (not the one in the linux kernel) for nvme which the company I work for uses for internal benchmarking, I was asked to implement an hardware reset.

I've followed the spec and did the following:
1. disable the en bit and wait until the ctrl is off.
2. set the shutdown bit and wait until the ctrl completed shutdown.
3. did a pci reset.
4. set the num of queues in the aqa register.
5. populate the acq and asq register with the physical addr ofthe buffers.
6. configure the cc register with the default values.
7. enable the device via the en bit and wait until the ready bit it set.
8. prepate a ctrl id cmd on the sq and send a doorbell.
9. poll for completion.

my issue is that I never get a completion for that request.
am I doing something wrong? is there any way to query the controller for status that might help me figure out what I did wrong or what is the status of the controller?
are there any limitations on the addresses the admin queue can use?

Thanks,

Dagg.
