From: muthucrazy90@gmail.com (muthu crazy)
Date: Sun, 14 Jan 2018 09:26:23 +0530
Subject: RDY bit clarification
Message-ID: <CADLzrv-QioecdwfNNfipio6iWBzsaDcHovOyAV4qGu8aLwv7Tg@mail.gmail.com>

Why does linux nvme target code is checking for NVME_CSTS_RDY == 1
before submitting any IO commands to device. Is there any chance RDY
can go down after the controller initialization. It make sense if we
check for CFS instead of RDY.

Isn't causing performance drop?

Thanks in advance,
Muthu
