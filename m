From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 22 Jun 2015 15:17:07 +0000
Subject: [PATCH] NVMe: Fix IO for extended metadata formats
In-Reply-To: <20150622053417.GA29813@lst.de>
References: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
 <20150622053417.GA29813@lst.de>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CBA2D95@fmsmsx104.amr.corp.intel.com>

> On Fri, Jun 19, 2015@11:07:30AM -0600, Keith Busch wrote:
> > This fixes io submit ioctl handling when using extended metadata
> > formats. When these formats are used, the user provides a single virtually
> > contiguous buffer containing both the block and metadata interleaved,
> > so the metadata size needs to be added to the total length and not mapped
> > as a separate transfer.
> >
> > The command is also driver generated, so this patch does not enforce
> > blk-integrity extensions provide the metadata buffer.
> 
> Does this actually work properly?  I'd assume the block layer might
> not be too happy if we have weird arbitrary sizes for this additional
> metadata.

Similar to SG_IO, we can submit arbitrary length commands using the nvme
passthrough. It seems to work. Here's a test I did using the "nvme-cli"
program.

First showing the namespace is formatted using a metadata size 8,
capable of only extended settings.

  # nvme id-ns /dev/nvme0n1
  ...
  mc      : 0x1
  ...
  lbaf  1 : ms:8   ds:9  rp:0x2 (in use)
  ...

Create a random 520 byte file (512 bytes for data + 8 for metadata):

  # dd if=/dev/urandom of=rand.file.out bs=520 count=1

Write that 520 bytes using the write passthru:

  # nvme write /dev/nvme0n1 --data-size=520 --data=rand.file.out
  write success

Read it back:

  # nvme read /dev/nvme0n1 --data-size=520 --data=rand.file.in
  read success

Verify the two files are the same:

  # diff rand.file.in rand.file.out
  # echo $?
  0

Similar test using 8 blocks instead of 1:

  # dd if=/dev/urandom of=rand.file.out bs=520 count=8
  # nvme write /dev/nvme0n1 --block-count=7 --data-size=4160 --data=rand.file.out
  # nvme read /dev/nvme0n1 --block-count=7 --data-size=4160 --data=rand.file.in
  # diff rand.file.out rand.file.in
  #
