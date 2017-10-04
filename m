From: nnlnachu@gmail.com (Nachammai Lakshmanan)
Date: Wed, 4 Oct 2017 17:43:05 +0530
Subject: A way in nvme driver to control the maximum queue depth
Message-ID: <CAEy7waaGj01g0eXG58e4b8_rDpg23ZW9puWZzCBe1vWT=v1gHA@mail.gmail.com>

Hi,



I am looking for an ioctl to enable queue depth greater than 1.
Something similar to SG_SET_COMMAND_Q (which is for SCSI devices).

And also is there a way to get/set the max queue depth at driver layer
? (For, SCSI device this can be done by using SG_GET_SCSI_ID ? where
sg_scsi_id structure has a field(d_queue_depth) to get/set queue
depth)



Regards,

Nachammai
