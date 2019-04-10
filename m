From: luzmaximilian@gmail.com (Maximilian Luz)
Date: Wed, 10 Apr 2019 15:33:21 +0200
Subject: Potential bug in queue_count_set
Message-ID: <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>

Hi all,

I just stumbled (more or less randomly) over this piece of code
(/drivers/nvme/host/pci.c, v5.1-rc4):

147: static int queue_count_set(const char *val, const struct kernel_param *kp)
148: {
149: 	int n = 0, ret;
150:
151: 	ret = kstrtoint(val, 10, &n);
152: 	if (ret)
153: 		return ret;
154: 	if (n > num_possible_cpus())
155: 		n = num_possible_cpus();
156:
157: 	return param_set_int(val, kp);
158: }

Link with context: https://github.com/torvalds/linux/blob/v5.1-rc4/drivers/nvme/host/pci.c#L154-L155

It looks like lines 154, 155 don't achieve anything as `n` is not being
used afterwards. Sorry if this is already known or a non-issue, just
wanted to let you guys know.

Maximilian
