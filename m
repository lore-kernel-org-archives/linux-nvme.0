From: alon@vastdata.com (Alon Horev)
Date: Thu, 1 Mar 2018 09:52:16 +0200
Subject: Status of "nvmet: Add feature close connection from target side"
Message-ID: <CAF9HSim=BXt_nFEGYs_yzzcdQyxsw2+pK6X-ZNo9Wr-f2AubJg@mail.gmail.com>

Hi,

A set of patches was submitted to the mailing list on Oct 10 by
israelr at mellanox.com.
In terms of due process, what should be done in order to merge the
feature upstream? we'd be happy to contribute.

The use case is pretty straightforward: in case a node is misbehaving
in a cluster we'd like to fence it. Changing the 'allowed_hosts'
doesn't affect already existing connections, therefore, 'force_close'
on these hosts would enable disconnecting them to prevent them for
doing harm.

Thanks, Alon Horev
VastData
