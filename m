From: bdeyal@gmail.com (=?UTF-8?B?15DXmdeZ15wg15HXnyDXk9eV15M=?=)
Date: Thu, 3 May 2018 18:15:54 +0300
Subject: BLKZEROOUT ioctl and WriteZero opcode
Message-ID: <CAPrnrPDEdOFKxuZNQo_BhY8Nf2MfcB=DgbzDEDV7JHx5_+-gnQ@mail.gmail.com>

Hi all,

There is an ioctl command BLKZEROOUT that accepts range (lba + number
of block to zero)

Suppose:
Block device is an nvme device (e.g. /dev/nvme0nX)
Device does support the WriteZeroes opcode.

If so, does the kernel make use of the WriteZeroes opcode in the
implementation of BLKZEROOUT ?
Same question for BLKDISCARD.

Thanks
Eyal.
