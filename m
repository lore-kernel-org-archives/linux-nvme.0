From: pmenzel@molgen.mpg.de (Paul Menzel)
Date: Wed, 18 Oct 2017 12:58:04 +0200
Subject: How to improve long suspend time in `nvme_shutdown_ctrl`
In-Reply-To: <20171018074523.GA20872@infradead.org>
References: <72b666c9-dd57-ef87-e89e-ba280f34e90c@molgen.mpg.de>
 <20171018074523.GA20872@infradead.org>
Message-ID: <e6cf0383-038f-b8e5-22e8-0956e04f0edd@molgen.mpg.de>

Dear Christoph,


Am 18.10.2017 um 09:45 schrieb Christoph Hellwig:
> On Tue, Oct 17, 2017@10:33:56PM +0200, Paul Menzel wrote:
>> Is that the right register to read? Can this be improved? If not, is that a
>> firmware bug?
> 
> Take a look at nvme_shutdown_ctrl - it's pretty simple.
> 
> It asks the device to shut down, and then polls the controller status
> register every 10 milliseconds if the shutdown has completed.
> 
> So the drive performs as expected, but it is indeed rather slow.

Thank you. Then for the record, here is the device in question. 
(Hopefully that?s the culprit.) I?ll contact TUXEDO if they can get in 
touch with Samsung.

```
$ sudo nvme id-ctrl /dev/nvme0n1
NVME Identify Controller:
vid     : 0x144d
ssvid   : 0x144d
sn      : S316NA0HA02167
mn      : SAMSUNG MZVKW512HMJP-00000
fr      : CXA7300Q
rab     : 2
ieee    : 002538
cmic    : 0
mdts    : 0
cntlid  : 2
ver     : 10200
rtd3r   : 186a0
rtd3e   : 4c4b40
oaes    : 0
oacs    : 0x17
acl     : 7
aerl    : 3
frmw    : 0x16
lpa     : 0x3
elpe    : 63
npss    : 4
avscc   : 0x1
apsta   : 0x1
wctemp  : 343
cctemp  : 346
mtfa    : 0
hmpre   : 0
hmmin   : 0
tnvmcap : 512110190592
unvmcap : 0
rpmbs   : 0
sqes    : 0x66
cqes    : 0x44
nn      : 1
oncs    : 0x1f
fuses   : 0
fna     : 0
vwc     : 0x1
awun    : 255
awupf   : 0
nvscc   : 1
acwu    : 0
sgls    : 0
subnqn  :
ps    0 : mp:6.80W operational enlat:0 exlat:0 rrt:0 rrl:0
           rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:5.60W operational enlat:0 exlat:0 rrt:1 rrl:1
           rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:4.40W operational enlat:0 exlat:0 rrt:2 rrl:2
           rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0400W non-operational enlat:210 exlat:1500 rrt:3 rrl:3
           rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0050W non-operational enlat:2200 exlat:6000 rrt:4 rrl:4
           rwt:4 rwl:4 idle_power:- active_power:-
```


Kind regards,

Paul
