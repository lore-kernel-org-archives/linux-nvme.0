From: nisha.miller420@gmail.com (Nisha Miller)
Date: Tue, 4 Apr 2017 18:28:30 -0700
Subject: PRP1 not min page size aligned in read/write cmds
Message-ID: <CAG3=cOn1rZHQ7dETovf5n=_3QRSMOrZFC+PibNJiQeH0kr2ZWA@mail.gmail.com>

Hi,

We have specified Min page size as 4K in our FW. So we expect that all
read/write commands sent to FW will operate on multiples of 4K blocks.
However we observe that sometimes we receive read/write commands where
the PRP1 address is not 4K aligned, e.g 0x84CD5CD50. Is this normal or
expected?

TIA
Nisha
