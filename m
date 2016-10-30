From: roysh@mellanox.com (Roy Shterman)
Date: Sun, 30 Oct 2016 14:17:46 +0200
Subject: question about working with SRQ in nvmet_rdma from multiples hosts
Message-ID: <af00bab6-e995-fdad-a117-bcdd39ae2a1d@mellanox.com>

Hi,

Maybe I'm missing something but it seems there is a bug in the SRQ 
implementation in nvmet_rdma,

In case we work with two different hosts that are connected to the same 
SRQ we can get two different commands with the same command_id.

I couldn't found any related code that handle this issue.

is it a problem? should we use qp_number to change the command_id to be 
unique across different hosts?


Thanks,

Roy
