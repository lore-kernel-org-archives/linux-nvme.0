From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Wed, 15 May 2013 15:17:08 -0500
Subject: Expected behaviour for device hang
Message-ID: <OF5FBD14D9.6D2E87EF-ON86257B6C.006CDB74-86257B6C.006F6E86@hgst.com>

What is the expected behaviour of the driver if a device hangs? If  a 
device stops processing commands, the commands will eventually timeout, 
which is handled in 'nvme_kthread' with a call to 'nvme_cancel_ios'. 
However, this is not calling bio_completion. Every second the cycle 
repeats, cancelling the same I/Os and syslog fills up with the message 
'Cancelling I/O xx'. I was expecting that the ios that timeout would be 
completed as failed and freed.

Is there something that is still TBD, or am I just missing something.

Thanks,
Dave
