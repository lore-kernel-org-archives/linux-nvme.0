From: mlin@kernel.org (Ming Lin)
Date: Mon, 16 Nov 2015 21:53:59 -0800
Subject: [RFC] generic NVMe target and NVMe loop driver
In-Reply-To: <1447662575.23230.105.camel@haakon3.risingtidesystems.com>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1447659004.23230.102.camel@haakon3.risingtidesystems.com>
 <1447661338.10221.8.camel@hasee>
 <1447662575.23230.105.camel@haakon3.risingtidesystems.com>
Message-ID: <1447739639.8017.8.camel@hasee>

On Mon, 2015-11-16@00:29 -0800, Nicholas A. Bellinger wrote:
> On Mon, 2015-11-16@00:08 -0800, Ming Lin wrote:
> > On Sun, 2015-11-15@23:30 -0800, Nicholas A. Bellinger wrote:
> > > On Sat, 2015-11-07@18:00 +0100, Christoph Hellwig wrote:
> > > > This series continues the NVMe host drive split and also starts adding a
> > > > consume for it.  The consumer is mostly interesting for developers at this
> > > > point as it's simply a 'loopback' NVMe device that ties the split NVMe
> > > > driver fronted into the new generic NVMe target subsystem.
> > > 
> > > Very excited to see this code posted.  8-)
> > > 
> > > > This was developed for our NVMe over Fabrics prototype, but will also be useful for
> > > > other work like Ming's virtio-nvme or event an implementation traditional
> > > > PCIe NVMe using vhost.
> > > > 
> > > 
> > > Wrt to vhost-nvme, the WIP code (Dr. Hannes + Dave CC'ed) I'm currently
> > > hacking on is here:
> > > 
> > > https://git.kernel.org/cgit/linux/kernel/git/nab/target-pending.git/log/?h=vhost-nvme-wip
> > > 
> > > Note it's still a week or two away (using rts-megasas as a reference)
> > > from actually functioning across a modest number of queue resources, but
> > > should at least give interested folks an idea of how things look so far.
> > 
> > Hi Nic,
> > 
> > FYI,
> > 
> > I have done the vhost-nvme patches(based on our previous discussion) on
> > top of NVMe target.
> > 
> > I'll post kernel & qemu patches early this week.
> > 
> 
> Great.  Looking forward to seeing the prototype code.
> 
> > But the tests I have done so far didn't show competitive performance
> > compared with vhost-scsi. Maybe because the mmio thing is slow.
> > 
> 
> Anything interesting hot-spots that show up in perf output..?

To ease development, I use nested kvm.
"vm_host" runs on bare metal and "vm_guest" runs on "vm_host"

I just integrated Google's extension to vhost-nvme.
https://github.com/rlnelson-git/linux-nvme.git

It's amazing performance improves a lot. 
I use a 256M /dev/ram0 on vm_host as backend.

fio 4k read:
qemu-nvme: ~20M to ~30M
qemu-vhost-nvme + google ext: 80M to 200M(not very stable though)

(BTW, still waiting for employer's approval to send out patches)

   PerfTop:    1039 irqs/sec  kernel:99.8%  exact:  0.0% [4000Hz cpu-clock],  (all, 4 CPUs)
---------------------------------------------------------------------------------------------
    36.93%  [kernel]       [k] _raw_spin_unlock_irq          
    20.98%  [kernel]       [k] vmx_handle_external_intr      
    10.10%  [kernel]       [k] _raw_spin_unlock_irqrestore   
     4.95%  [kernel]       [k] __mutex_unlock_slowpath       
     4.41%  [kernel]       [k] lock_acquire                  
     4.15%  [kernel]       [k] lock_is_held                  
     2.30%  [kernel]       [k] mutex_lock_nested             
     1.68%  [kernel]       [k] lock_release                  
     1.14%  [kernel]       [k] put_compound_page             
     0.93%  [kernel]       [k] debug_lockdep_rcu_enabled     
     0.66%  [kernel]       [k] check_preemption_disabled     
     0.64%  [kernel]       [k] __schedule                    
     0.62%  [kernel]       [k] lock_acquired                 
     0.54%  [kernel]       [k] rcu_lockdep_current_cpu_online
     0.54%  [kernel]       [k] preempt_count_sub             
     0.54%  [kernel]       [k] preempt_count_add             
     0.46%  [kernel]       [k] find_vma                      
     0.45%  [kernel]       [k] vmcs_writel                   
     0.40%  [kernel]       [k] ___might_sleep                
     0.38%  [kernel]       [k] rcu_note_context_switch       
     0.37%  [kernel]       [k] rcu_read_lock_sched_held      
     0.32%  [kernel]       [k] __rcu_is_watching             
     0.32%  [kernel]       [k] follow_trans_huge_pmd         
     0.31%  [kernel]       [k] debug_smp_processor_id        
     0.22%  [kernel]       [k] follow_page_mask              
     0.18%  [kernel]       [k] __get_user_pages              
     0.16%  [kernel]       [k] vmx_read_guest_seg_ar         
     0.16%  [kernel]       [k] nvmet_vhost_rw                
     0.15%  [kernel]       [k] kthread_should_stop           
     0.14%  [kernel]       [k] schedule                      
     0.14%  [kernel]       [k] rcu_is_watching               
     0.12%  [kernel]       [k] nvmet_vhost_sq_thread         
     0.11%  [kernel]       [k] get_parent_ip                 
     0.11%  [kernel]       [k] _raw_spin_lock_irqsave   
