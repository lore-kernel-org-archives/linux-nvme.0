From: gili.buzaglo@taec.toshiba.com (Gili Buzaglo)
Date: Mon, 8 Aug 2016 01:34:58 -0700
Subject: Configured nqn
Message-ID: <14E6FCBE6C7E3A47A6CD7D77E639D51C2F73FABD@oczmail.ocz.ocztechnology.com>

Hi
I was wondering if there's a special reason why not to support preconfigured initiator nqn from a file.
(similar to iscsi in /etc/iscsi/initiatorname.iscsi).

For example libvirt iscsi volume driver in nova in openstack, uses the iscsi file to retrieve the initiator name and send it
To cinder to allow access.
We thought it would be required to support nvmf in the same manner.

Thanks
-gili

CONFIDENTIAL COMMUNICATION:  This communication including any attached file(s) is CONFIDENTIAL, intended only for the named recipient (s) above and contains trade secrets or other information that is exempt from disclosure under applicable law.  Any use, dissemination, distribution or copying of this communication and any file attachments by anyone other than the named recipient (s) is strictly prohibited. If you have received this communication in error, please immediately notify us by reply electronic mail and permanently delete the original transmission and any attachments from your computer system and any copies of this message and file attachments. Thank you.
