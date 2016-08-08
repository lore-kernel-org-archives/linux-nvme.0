From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Aug 2016 11:47:58 +0300
Subject: Configured nqn
In-Reply-To: <14E6FCBE6C7E3A47A6CD7D77E639D51C2F73FABD@oczmail.ocz.ocztechnology.com>
References: <14E6FCBE6C7E3A47A6CD7D77E639D51C2F73FABD@oczmail.ocz.ocztechnology.com>
Message-ID: <f94a27cf-8dcf-c881-4fe9-a45d0ce7c9c6@grimberg.me>

> Hi

Hey Gili,

> I was wondering if there's a special reason why not to support preconfigured initiator nqn from a file.
> (similar to iscsi in /etc/iscsi/initiatorname.iscsi).

It was raised on the list just last week. I think Jay
has (of was :)) volunteered.

> For example libvirt iscsi volume driver in nova in openstack, uses the iscsi file to retrieve the initiator name and send it
> To cinder to allow access.
> We thought it would be required to support nvmf in the same manner.

Its definitely useful and easy enough to do. You are welcome to send
a patch to nvme-cli ;)
