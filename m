From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 24 Jan 2018 16:01:01 +0100
Subject: [RFD] passthrough ioctl interface considered harmful?
Message-ID: <20180124150101.rxalj4x44bmwtaba@linux-x5ow.site>

Hey @all,

Inspired by the discussion at [1] I've distilled a small test-case [1] which
deletes QID 1 submission and completions queues. When running this while I/O
is in-flight we obviously get timeouts and thus force controller resets.

For some commands commands (nvme_admin_format_nvm, nvme_admin_sanitize_nvm) we
do already check whether it is a good idea or not and at least warn the user
about the possible side effects.

Question here is, should we extend the list and/or block specific commands (at
least while I/O is running)?

Thanks,
	Johannes

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-January/015181.html
[2]
#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <stropts.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/nvme.h>

struct nvme_passthru_cmd {
        __u8    opcode;
        __u8    flags;
        __u16   rsvd1;
        __u32   nsid;
        __u32   cdw2;
        __u32   cdw3;
        __u64   metadata;
        __u64   addr;
        __u32   metadata_len;
        __u32   data_len;
        __u32   cdw10;
        __u32   cdw11;
        __u32   cdw12;
        __u32   cdw13;
        __u32   cdw14;
        __u32   cdw15;
        __u32   timeout_ms;
        __u32   result;
};
#define nvme_admin_cmd nvme_passthru_cmd
#define NVME_IOCTL_ADMIN_CMD    _IOWR('N', 0x41, struct nvme_admin_cmd)


int main(void)
{
	struct nvme_delete_queue cmd = { 0 };
	int fd;
	int ret;

	fd = open("/dev/nvme0n1", O_RDWR);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	cmd.qid = 1;

	cmd.opcode = nvme_admin_delete_cq;
	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
	if (ret < 0)
		perror("ioctl");

	cmd.opcode = nvme_admin_delete_sq;
	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
	if (ret < 0)
		perror("ioctl");

	close(fd);

	return 0;
}
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
