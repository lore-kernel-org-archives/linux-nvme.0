From: felipe@nutanix.com (Felipe Franciosi)
Date: Fri, 15 Feb 2019 21:19:02 +0000
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Message-ID: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>

Hi All,

I'd like to attend LSF/MM this year and discuss the kernel performance when accessing NVMe devices, specifically (but not limited to) Intel Optane Memory (which boasts very low latency and high iops/throughput per NVMe controller).

Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. For hypervisors, where storage devices can be exclusively accessed with userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient. That remains true even in the latest versions of the kernel.

I have presented work focusing on hypervisors in several conferences during this time. Although I appreciate the LSF/MM is more discussion-oriented, I am linking a couple of these presentations for reference:

Flash Memory Summit 2018
https://www.flashmemorysummit.com/English/Collaterals/Proceedings/2018/20180808_SOFT-202-1_Franciosi.pdf

Linux Piter 2018
https://linuxpiter.com/system/attachments/files/000/001/558/original/20181103_-_AHV_and_SPDK.pdf

For LSF/MM, instead of focusing on hypervisors, I would like to discuss what can be done to achieve better efficiency and performance when using the kernel. My data include detailed results considering various scenarios like different NUMA configurations, IRQ affinity and polling modes.

Thanks,
Felipe
