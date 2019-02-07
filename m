From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 7 Feb 2019 17:12:52 +0000
Subject: [LSF/MM TOPIC] BPF for Block Devices
Message-ID: <40D2EB06-6BF2-4233-9196-7A26AC43C64E@raithlin.com>

Hi All

> A BPF track will join the annual LSF/MM Summit this year! Please read the updated description and CFP information below.

Well if we are adding BPF to LSF/MM I have to submit a request to discuss BPF for block devices please!

There has been quite a bit of activity around the concept of Computational Storage in the past 12 months. SNIA recently formed a Technical Working Group (TWG) and it is expected that this TWG will be making proposals to standards like NVM Express to add APIs for computation elements that reside on or near block devices.

While some of these Computational Storage accelerators will provide fixed functions (e.g. a RAID, encryption or compression), others will be more flexible. Some of these flexible accelerators will be capable of running BPF code on them (something that certain Linux drivers for SmartNICs support today [1]). I would like to discuss what such a framework could look like for the storage layer and the file-system layer. I'd like to discuss how devices could advertise this capability (a special type of NVMe namespace or SCSI LUN perhaps?) and how the BPF engine could be programmed and then used against block IO. Ideally I'd like to discuss doing this in a vendor-neutral way and develop ideas I can take back to NVMe and the SNIA TWG to help shape how these standard evolve.

To provide an example use-case one could consider a BPF capable accelerator being used to perform a filtering function and then using p2pdma to scan data on a number of adjacent NVMe SSDs, filtering said data and then only providing filter-matched LBAs to the host. Many other potential applications apply. 

Also, I am interested in the "The end of the DAX Experiment" topic proposed by Dan and the " Zoned Block Devices" from Matias and Damien.

Cheers
 
Stephen

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/netronome/nfp/bpf/offload.c?h=v5.0-rc5
 
    
