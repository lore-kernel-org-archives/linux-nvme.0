From: mlin@minggr.net (Ming Lin)
Date: Tue, 6 Jan 2015 23:42:48 -0800
Subject: [PATCHv2 00/10] Second attempt at blk-mq + nvme hotplug fixes
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <CAF1ivSbxXH0CU+PtvhxdOb-WjGreMoJ-nQYr89xn7ZhhtAQKcw@mail.gmail.com>

On Tue, Jan 6, 2015@6:57 PM, Keith Busch <keith.busch@intel.com> wrote:
> Second try, this time tested against many more scenarios than before
> with error injection and surprise hot-removal and intermittent resets.
>
> I'm adding a lot of stuff outside the driver, but I didn't find a
> cleaner way to a lot of these things. This makes me a little nervous,
> so please let me know if anything seems amiss here. I don't think any
> of the blk-mq changes could possibly be harmful to anyone else since
> nvme is the only driver that uses most of the additions.
>
> The only issue remaining I found is unfreezing queues might tigger the
> percpu_ref_reinit WARN_ON_ONCE when the driver restarts a request_queue
> with queued up IO's.
>
> This is against linux-block/for-next.

Hi Keith,

Tested with qemu-nvme. Hotplug seems work., but has some issues.

On guest: run fio for a while
root at block:~# fio --name=global --filename=/dev/nvme0n1 --direct=1 --bs=4k \
     --rw=randrw --ioengine=libaio --iodepth=128 --name=foobar
foobar: (g=0): rw=randrw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
2.0.8
Starting 1 process
Jobs: 1 (f=1): [m] [10.3% done] [3746K/3980K /s] [936 /995  iops] [eta
08m:52s]s]

On guest: then remove nvme device
root at block:~# time echo 1 > /sys/devices/pci0000:00/0000:00:04.0/remove
real 1m0.040s
user 0m0.000s
sys 0m0.012

It works, but took long time(1 minutes) to return.
And during this time frame, the whole qemu system was not responsible.
Ping from host to guest also failed.

mlin at minggr:~$ ping 192.168.122.89
PING 192.168.122.89 (192.168.122.89) 56(84) bytes of data.
>From 192.168.122.1 icmp_seq=15 Destination Host Unreachable
>From 192.168.122.1 icmp_seq=16 Destination Host Unreachable

Thanks,
Ming
