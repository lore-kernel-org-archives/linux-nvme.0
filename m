From: maoz.dani@gmail.com (dani maoz)
Date: Tue, 3 Jul 2018 06:34:06 +0300
Subject: host submit bi-directional buffer
Message-ID: <CAKoHnaH_2wZ4eO_K_t80LYENM2P8y-YLvddYcYyWy36+uHZw5g@mail.gmail.com>

Hi
I added a new command vendor specific to core.c (host).
I would like the buffer to bi-directional and send a read command to
my device, but the device should read the content of the buffer before
update it with new data.
I update the function nvme_alloc_request, so the direction would be like write.
the device was able to read the buffer It's seems the device write the
new information on PCI bus, but the buffer in the host hasn't change
(NVME transaction success, used nvme-cli),
What is the lower layer the buffer is copied?
Should I also update block also the block a layer,  ?
Is there a reason to declare the buffer read or write but not bi-directional?
kernel 4.18_rc1
Thanks in advance
